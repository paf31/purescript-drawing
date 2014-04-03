module.exports = function(grunt) {

  "use strict";

  grunt.initConfig({ 
  
    libFiles: [
      "src/**/*.purs",
      "bower_components/purescript-*/src/**/*.purs",
      "bower_components/purescript-*/src/**/*.purs.hs"
    ],
    
    clean: {
      lib: ["js", "externs"]
    },
  
    "purescript-make": {
      lib: {
        src: "<%=libFiles%>"
      }
    }
  });

  grunt.loadNpmTasks("grunt-contrib-clean");
  grunt.loadNpmTasks("grunt-purescript");
  grunt.loadNpmTasks("grunt-execute");
  
  grunt.registerTask("test", ["purescript:tests"]);
  grunt.registerTask("lib", ["purescript-make:lib"]);
  grunt.registerTask("default", ["lib"]);
};
