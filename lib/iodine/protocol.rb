module Iodine
  # The Protocol class is used only for documenting the Protocol API, it will not be included when requiring `iodine`.
  #
  # A dynamic (stateful) protocol is defined as a Ruby class instance which is in control of one single connection.
  #
  # It is called dynamic because it is dynamically allocated for each connection and then discarded,
  # also it sounded better then calling it "the stateful protocol", even though that's what it actually is.
  #
  # It is (mostly) thread-safe as long as it's operations are limited to the scope
  # of the object.
  #
  # <b>The Callbacks</b>
  #
  # A protocol class <b>MUST</b> contain ONE of the following callbacks:
  #
  # on_data:: called whened there's data available to be read, but no data was read just yet. `on_data` will not be called again untill all the existing network buffer was read (edge triggered event).
  # on_message(buffer):: the default `on_data` implementation creates a 1Kb buffer and reads data while recycling the same String memory space. The buffer is forwarded to the `on_message` callback before being recycled. The buffer object will be over-written once `on_message` returns, so creating a persistent copy requires `buffer.dup`.
  #
  # A protocol class <b>MAY</b> contain any of the following optional callbacks:
  #
  # on_open:: called after a new connection was accepted and the protocol was linked with Iodine's Protocol API. Initialization should be performed here.
  # ping:: called whenever timeout was reached. The default implementation will close the connection unless a protocol task ({Protocol#defer}, `on_data` or `on_message`) are busy in the background.
  # on_shutdown:: called if the connection is still open while the server is shutting down. This allows the protocol to send a "going away" frame before the connection is closed and `on_close` is called.
  # on_close:: called after a connection was closed, for any cleanup (if any).
  #
  # WARNING: for thread safety and connection management, `on_open`, `on_shutdown`, `on_close` and `ping` will all be performed within the reactor's main thread.
  # Do not run long running tasks within these callbacks, or the server might block while you do.
  # Use {#defer} to run protocol related tasks (this locks the connection, preventing it from running more then one task at a time and offering thread safety),
  # or {#run} to run asynchronous tasks that aren't protocol related.
  #
  # <b>Connection timeouts</b>
  #
  # By setting a class variable called `@timeout` it is possible to define a default timeout for new connections. However, changing this default timeout should be performed using the {#timeout} methods.
  #
  # <b>The API:</b>
  #
  # After a new connection is accepted and a new protocol object is created, the protocol will be linked with Iodine's Protocol API.
  # Only the main protocol will be able to access the API within `initialize`, so it's best to use `on_open` for any Initialization required.
  #
  module Protocol
  end
end
