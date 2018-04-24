Array::seq ?= () ->
  [ func, idx, cb, args... ] = arguments
  if idx instanceof Function
    cb = idx
    idx = 0
  return cb.apply @, [ undefined ].concat(args) if idx >= @.length
  next = () =>
    return cb arguments[0] if arguments[0] instanceof Error
    Array::seq.apply @, [ func, idx + 1, cb ].concat(a for a in arguments)
  try
    func.apply @, [ @[idx], idx, next ].concat(args)
  catch e
    return cb e
