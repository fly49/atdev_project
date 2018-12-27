Ruby version: 2.4.4 / Rails 5.2.1

Steps before run application:
* Configure `ENV['REDIS_URL]` for your running environment 
* Start `redis-server`
* Intitialize `PG::connection` by running postgresql
* Change `database.yml` setting according to your database
* Create database and run migrations

## Endpoint Overview
| Endpoint Category | Description |
| :---------------: | ------------- | 
| /convert/ |  Returns converted data based on sending params,<br> for e.g. `/convert/?from=BTC&to=USD&given=1`<br> Query parameters: <br> `from` - any coin <br> `to` - any coin or USD <br> `given` - currency amount |
| /history/ |  Returns history of every convertation made descending by date      |

### Sidekiq worker
This application has sidekiq worker that communicate with https://api.coinmarketcap.com/ via API_KEY, so you need to specify it in config to let app work properly. You can get it [here](https://pro.coinmarketcap.com/signup/).
