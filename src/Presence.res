type t

type presence = {metas: array<Presence.t>}

type presences = Js.Dict.t<presence>

type diff = {
  joins: presences,
  leaves: presences,
}

type presenceCallback = (~id: string, ~currentPresence: presence, ~newPresence: presence) => unit

type presenceOpts = {
  state: string,
  diff: string,
}

@module("phoenix") @new external make: (Recursive.Channel.t, option<presenceOpts>) => t = "Presence"

@send
external syncDiff: (
  ~currentState: presences,
  ~diff: diff,
  ~onJoin: presenceCallback=?,
  ~onLeave: presenceCallback=?,
  unit,
) => presences = "syncDiff"

@send
external syncState: (
  ~currentState: presences,
  ~newState: presences,
  ~onJoin: presenceCallback=?,
  ~onLeave: presenceCallback=?,
  unit,
) => presences = "syncState"
