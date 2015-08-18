"use strict";

// module Graphics.Drawing.Color

exports.byteToHex = function(n) {
    
    var s = (n = Math.min(255, Math.max(n, 0)) | 0).toString(16);
    return n >= 16 ? s : "0" + s;
};