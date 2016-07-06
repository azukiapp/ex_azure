/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */
// Adds the systems that shape your system
systems({
  "ex-azure": {
    // Dependent systems
    depends: [],
    // More images:  http://images.azk.io
    image: {"docker": "azukiapp/elixir:1.3"},
    // Steps to execute before running instances
    provision: [
      // "mix do deps.get, compile",
    ],
    workdir: "/azk/#{manifest.dir}",
    command: ["mix", "app.start"],
    wait: false,
    mounts: {
      '/azk/#{manifest.dir}'       : sync("."),
      '/azk/#{manifest.dir}/deps'  : persistent("./deps"),
      '/azk/#{manifest.dir}/_build': persistent("./_build"),
      '/root/.hex'                 : persistent("#{env.HOME}/.hex"),
      '/root/.hex/hex.config'      : path("#{env.HOME}/.hex/hex.config"),
    },
    envs: {
      // Make sure that the PORT value is the same as the one
      // in ports/http below, and that it's also the same
      // if you're setting it in a .env file
      MIX_ENV: "test",
    },
  },
});
