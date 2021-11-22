module rec Push: {
  type t

  @new external make: (Channel.t, ~event: string, ~payload: 'a, ~timeout: int=?, unit) => t = "Push"
  @send external resend: (t, ~timeout: int) => unit = "resend"
  @send external send: t => unit = "send"
  @send external receive: (t, ~status: string, ~callback: 'a => unit) => t = "receive"
} = Push
and Channel: {
  type t
  type ref
  @send external make: (Socket.t, string, 'a) => Channel.t = "channel"
  @send external join: (Channel.t, ~timeout: int=?, unit) => Push.t = "join"
  @send
  external push: (Channel.t, ~event: string, ~payload: 'a, ~timeout: int=?, unit) => Push.t = "push"
  @send external leave: (Channel.t, ~timeout: int=?, unit) => Push.t = "leave"
  @send external on: (Channel.t, string, 'a => unit) => ref = "on"
  @send external off: (Channel.t, string, ref) => bool = "off"
  @send external onClose: (Channel.t, unit => unit) => unit = "onClose"
  @send external onError: (Channel.t, 'a => unit) => unit = "onError"
  @send external onMessage: (Channel.t, string, 'a, ref) => 'a = "onMessage"
} = Channel
