// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js.erb$/)
// const channels = require.context('.', true, /_channel(\.js|\.erb)$/);
channels.keys().forEach(channels)
