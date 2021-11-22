let socket = Socket.make("lobby:main", None)
Socket.connect(socket)

let chan = Channel.make(socket, "room:1234", None)

