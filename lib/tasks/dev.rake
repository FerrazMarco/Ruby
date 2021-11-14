namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    
    if Rails.env.development?
      show_spinner("DROP ....") { %x(rails db:drop:_unsafe) }
      show_spinner("CREATE ....") { %x(rails db:create) }
      show_spinner("MIGRATE ....") { %x(rails db:migrate) }
      
      %x(rails dev:add_mining_types) # <-- to run the task created bellow
      %x(rails dev:add_coins) # <-- to run the task created bellow
       
    end
  end
  
      desc "Cadastra as moedas"
      task add_coins: :environment do  
          show_spinner("ADD COINS ....") do
          coins = [
           {
              description: "Bitcoin",
              acronym: "BTC",
              url_image: "https://cdn-icons-png.flaticon.com/512/1490/1490849.png",
              mining_type: MiningType.find_by(acronym: 'PoW')
           },
           {
              description: "Etherum",
              acronym: "ETH",
              url_image: "https://cdn-icons-png.flaticon.com/512/2089/2089411.png",
              mining_type: MiningType.all.sample
           },
           {
              description: "Dash",
              acronym: "DASH",
              url_image: "https://cdn-icons-png.flaticon.com/512/825/825534.png",
              mining_type: MiningType.all.sample
           },
           {
               description: "Iota",
               acronym: "IOT",
               url_image: "https://cryptologos.cc/logos/iota-miota-logo.png",
               mining_type: MiningType.all.sample
           },
           {
               description: "ZCash",
               acronym: "ZEC",
               url_image: "https://cdn-icons-png.flaticon.com/512/4484/4484821.png",
               mining_type: MiningType.all.sample
           }
          ]
          
          coins.each do |coin|
              Coin.find_or_create_by!(coin)
          end
        end
      end
      
      desc "Cadastro dos tipos de mineração"
      task add_mining_types: :environment do
        show_spinner("ADD MINING TYPES ....") do
        mining_types = [
          {
            description: "Proof of Work",
            acronym: "PoW"
          },
          {
            description: "Proof of Stake",
            acronym: "PoS"
          },
          {
            description: "Proof of Capacity",
            acronym: "Poc"
          }
          ]
          mining_types.each do |mining_type|
              MiningType.find_or_create_by!(mining_type)
            end
          end
        end
       
  private
  def show_spinner(msg_start, msg_stop = "Done!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin          
      yield
      spinner.success("(#{msg_stop})")
  end
end
