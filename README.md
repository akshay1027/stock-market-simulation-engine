## APIs:
1) CRUD on meta data for companies | Not for users | Private API
2) Read API on stock prise of a company | For users | Public API
   This API has to update the base prise using some formula.


## Frontend:
1) Using Read API, show charts of prise changing for each company.


## Todo 3|1|23:
Am able to make the companies but there is some problem with editing the companies. I have sem exam on 7|3|23. I will continue again from that day.  

![image](https://user-images.githubusercontent.com/65683151/210415407-a0b17c8f-07b2-42a8-b230-dcae4214a91f.png)  
- Solved on 7|1|23


## Todo 9|1|23 | Find out the idea
- [X] The adding companies part, private API. 
- [X] how I can simulate the data in backend every 1 or 2 seconds once a request is made for a company s stock and stream it to the frontend.  
- [ ] Then will look to consume it in frontend using some chart library, have made some research on found some libraries, have to try them out!


## Create a socket endpoint:
mix phx.gen.socket Stock_exchange

## create a channel:
mix phx.gen.channel Company

## Websockets:
Request -> Socket -> Channel -> Topic -> Response


![image](https://user-images.githubusercontent.com/65683151/212335321-5797a71f-721e-4650-b5b7-6414f015aa04.png)


## Backend features:
- [X] Continously streaming data from backend to frontend.
- [X] Get company_id through request.
- [X] Using company_id, interact with DB. 
- [ ] Before streaming data to client, change the data from db and send to client. Getting data from DB has to be done only once to improve performance.
- [ ] Add/Assign company_id and stock_prise to socket state so that it can be passed around within phoenix callbacks/handlers.
- [ ] 

## Frontend features:
- [ ] Setup flutter and its environment
- [ ] Learn how to setup flutter client for websocket 
- [ ] Consume Phoenicx websocket APIs
- [ ] Decide how to stream the incoming data in chart form
- [ ]


- Messages that do not come from GenServer.call/2 or GenServer.cast/2 are handled by the handle_info/2 callback.  