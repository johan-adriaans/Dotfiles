module.exports = {
  "env": {
    "browser": true,
    "mootools/core": true,
    "mootools/more": true
  },
  "plugins": ["mootools"],
  "extends": "eslint:recommended",
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
