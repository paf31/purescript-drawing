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
  
    pscMake: {
      lib: {
        src: "<%=libFiles%>"
      }
    }
  });

  grunt.loadNpmTasks("grunt-contrib-clean");
  grunt.loadNpmTasks("grunt-purescript");
  
  grunt.registerTask("lib", ["pscMake:lib"]);
  grunt.registerTask("default", ["lib"]);
};
