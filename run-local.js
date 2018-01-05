const shell = require('shelljs');
const readline = require('readline');

const api = process.env.npm_config_api || 'https://intellifyqa-automation1.intellifydev.net';
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function runTests() {
  const browser = process.env.BROWSER || 'CHROME';
  const headless = process.env.HEADLESS || 'false';
  const cucumberExecPlan = `cucumber BROWSER=${browser} HEADLESS=${headless} -p essentials_local --format html --out=result/local-results.html`;

  if (process.platform === 'win32') {
    shell.cd('e2e-tests');
    shell.exec(cucumberExecPlan);
  } else {
    shell.exec(`xterm -e "cd e2e-tests && CHROME_DRIVER=chromedriver_mac && ESSENTIALS_API_HOST=${api} ${cucumberExecPlan}"`);
  }
}

rl.question(`Please remember to set your development config to point to ${api} .Press any key to continue.`, () => {
  rl.close();
  runTests();
});
