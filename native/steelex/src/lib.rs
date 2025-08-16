use steel::steel_vm::engine::Engine;

#[rustler::nif]
fn hello_from_rust() -> String {
    "from rust".to_string()
}

#[rustler::nif]
fn hello_from_scheme() -> String {
    let mut vm = Engine::new();

    // Given the compile-time considerations around NIFs, it's not yet clear
    // if they'd be most/only useful for specific, optimized? uses of steel.
    // Ports may be the required option for the generality we need.
    let _result = vm.run("(define greeting \"from scheme\")").unwrap();

    let greeting: String = vm.extract("greeting").unwrap();
    //println!("greeting: {}", greeting);
    assert_eq!("from scheme".to_string(), greeting);

    // TODO - can we avoid coercing it into a string and return the res/err?
    // ref https://github.com/rusterlium/rustler/blob/05f79740eb986cf9c338d2f3d96ebf95b35ad124/rustler/src/types/mod.rs#L122
    greeting
}

#[rustler::nif]
fn eval(chunk: String) -> String {
    let mut vm = Engine::new();

    let result = vm.run(chunk).unwrap();
    println!("{:?}", result);

    // TODO - move beyond just the string representation of the result
    result.get(1)
        .expect("Error: no result!")
        .to_string()
}

rustler::init!("Elixir.SteelEx.Native");
