#[rustler::nif]
fn hello() -> String {
    "from rust".to_string()
}

rustler::init!("Elixir.SteelEx");
