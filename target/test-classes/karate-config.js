function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev'; // a default environment
  }

  var config = {
    apiUrl: 'https://dev-drivetec-apis.schuecodigitalsolutions.com',
  };

  if (env === 'dev') {
    config.apiUrl = 'https://dev-drivetec-apis.schuecodigitalsolutions.com';
  } else if (env === 'stage') {
    config.apiUrl = 'https://stage-drivetec-apis.schuecodigitalsolutions.com';
  }

  karate.configure('ssl', true); // handle SSL if needed

  return config;
}