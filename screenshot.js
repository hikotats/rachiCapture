var fs = require('fs');
var json = JSON.parse(fs.read('pageLists.json'));

var props = {
    // Chrome
    pc:{
        ua: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36",
        //viewport: { width: 2560, height: 1440 }
        viewport: { width: 1200, height: 480 }
    },
    // iPhone 5, iOS 8.0.2
    mobile: {
        ua: "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12A405 Safari/600.1.4",
        viewport: { width: 640, height: 1136 }
    }
};

var casper = require('casper').create();

var url = casper.cli.args[0] || "https://market.airregi.jp";
var saveDir = casper.cli.args[1] || "_old";
var prop = casper.cli.args[2] == "mobile" ? props.mobile : props.pc;

casper.start();
casper.userAgent(prop.ua);
casper.zoom(1);
casper.viewport(prop.viewport.width, prop.viewport.height);

casper.start().each(json, function(self, link, i) {
    self.thenOpen(url + json[i].path, function(status) {
        if (url + json[i].path === this.getCurrentUrl()) {
            this.echo( "Successful open [" + i + "]: " + url + json[i].path );
            this.capture( saveDir + json[i].path + ".png");
            this.echo("Captured: " + saveDir + json[i].path + ".png");
            this.echo("------------------------------------------")
        } else {
            this.echo("Failed to open [" + i + "]: " + url + json[i].path);
            this.echo("------------------------------------------")
        }
    });
});

casper.run();
