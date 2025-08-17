use rustler::{Encoder, Env, Term, types::atom::Atom};
use steel::rvals::SteelVal;
use steel::steel_vm::engine::Engine;

// The Term will live for the lifetime of the NIF's environment
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

// TODO: error handling - need to provide {:err, <message>}
#[rustler::nif]
fn eval(env: Env, chunk: String) -> Result<Term, String> {
    let mut vm = Engine::new();

    let results = vm.run(chunk).unwrap(); // XXX

    Ok(steel_val_to_term(env, results.last().unwrap())) //XXX
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
