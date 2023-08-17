module.exports = {
  apps : [{
    name: 'API',
    script: 'procMal.sh',
    args: 'one two',
    max_restarts: 3,
    autorestart: true,
    stop_exit_codes: [50],
    min_uptime: 5000,
    watch: false,
    max_memory_restart: '1G',
    //force: true
  }]
};
