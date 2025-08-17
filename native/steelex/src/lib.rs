//! NIFs and helper functions to facilitate work between Elixir
//!   and [`Steel Scheme`] interepreters.
//! Heavily inspired by [`pythonx`], but uses [`rustler`].
//!
//! [`Steel Scheme`]: https://github.com/mattwparas/steel
//! [`pythonx`]: https://github.com/livebook-dev/pythonx
//! [`rustler`]: https://github.com/rusterlium/rustler

use rustler::{Encoder, Env, Term, types::atom::Atom};
use steel::rvals::SteelVal;
use steel::steel_vm::engine::Engine;

/// Note: the Term will live for the lifetime of the NIF's environment
fn steel_val_to_term<'a>(env: Env<'a>, val: &SteelVal) -> Term<'a> {
    match val {
        SteelVal::BoolV(b) => b.encode(env),
        SteelVal::IntV(i) => i.encode(env),
        SteelVal::NumV(f) => f.encode(env),
        SteelVal::CharV(c) => (*c as u32).encode(env),
        SteelVal::StringV(s) => s.as_str().encode(env),
        SteelVal::SymbolV(s) => {
            // TODO safer and consistent atom handling & BadArg
            match Atom::from_str(env, s.as_str()) {
                Ok(afs) => afs.encode(env),
                Err(_e) => s.as_str().encode(env),
            }
        },
        SteelVal::Void => Atom::from_str(env, "nil").unwrap().encode(env),

        // TODO - handle more sophisticated SteelVals, BadArg
        // Otherwise for now return a tagged tuple e.g. {:steel_val, <text representation of the SteelVal>}
        _ => {
            let tag = Atom::from_str(env, "steel_val").unwrap();
            let description = format!("{:?}", val);
            (tag, description).encode(env)
        }
    }
}

#[rustler::nif]
fn eval(env: Env, chunk: String) -> Term {
    let mut vm = Engine::new();

    // TODO: let rustler handle the tagged tuple
    match vm.run(chunk) {
        Ok(results) => match results.last() {
            Some(val) => {
                let tag = rustler::types::atom::ok();
                let res = steel_val_to_term(env, val);
                (tag, res).encode(env)
            },
            None => {
                // TODO comprehensive handling return cases
                let tag = rustler::types::atom::ok();
                let res = steel_val_to_term(env, &steel::rvals::SteelVal::from("nil".to_string()));
                (tag, res).encode(env)
            },
        },
        Err(e) => {
            // TODO - actually pass up the error
            let tag = rustler::types::atom::error();
            let error = format!("Steel evaluation error: {:?}", e);
            (tag, error).encode(env)
        }
    }
    // let results = vm.run(chunk).unwrap(); // XXX

    // Ok(steel_val_to_term(env, results.last().unwrap())) //XXX
}

#[rustler::nif(schedule = "DirtyCpu")]
fn run_repl() -> () {
    let vm = Engine::new();
    // TODO
    // - handle MultipleHandlers: expose as Elixir resource?
    // - how to propagate IO error from repl?
    // - {:ok, <done>} otherwise?
    // - printout in iex is mangled
    steel_repl::run_repl(vm).unwrap() //XXX
}

rustler::init!("Elixir.SteelEx.Native");
