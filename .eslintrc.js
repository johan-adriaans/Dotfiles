module.exports = {
  "extends": "eslint:recommended",
  "env": {
    "es6": true,
    "browser": true,
    "mootools/core": true,
    "mootools/more": true
  },
  "plugins": ["mootools"],
  "rules": {
    "indent": [
      "error",
      2
    ],
    "no-empty": ["off"],
    "no-undef": ["off"],
    "no-console": ["warn"],
    "linebreak-style": [
      "error",
      "unix"
    ],
    "semi": [
      "error",
      "always"
    ]
  }
};
