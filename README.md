# fyber_offers_client
A simple and small client for fyber offers api

## Rails

I decided not to user Active Record, since I will not need to store results, but I've used OpenStruct
to create an "model" so I can take benefit from some rails automatic operations(specially dealing with)
forms.

I tried to isolate all interaction with FyberAPI in just one module, for simplicity and separation of
concerns. I wrote a simple client(lib/fyber_client.rb) for this task.

As its a very simple app, I have not used any caching on requests and used simple HTML and form interaction.
I decided not to use ajax requests, although this could make the user experience a little better. Probably
in a real application this would be my choice.