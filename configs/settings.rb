$SETTINGS = {
    :tcp_client_address => 'localhost',
    :tcp_client_port    => 2020,
    :environment        => :development,
    :active_record => {
      :adapter => "sqlite3",
      :database => 'test.db'
    }
}
