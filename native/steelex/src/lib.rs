use steel::steel_vm::engine::Engine;

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
