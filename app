#!/usr/bin/env node

require('chromedriver');
var webdriver = require('selenium-webdriver');
var jimp = require('jimp');
var chalk = require('chalk');
var args = require('yargs')
            .string('u')
            .alias('u', 'username')
            .describe('u', 'Club penguin username')
            .string('p')
            .alias('p', 'password')
            .describe('p', 'Club penguin password')
            .boolean('d')
            .alias('d', 'dev')
            .describe('d', 'Developer mode')
            .default('d', false)
            .demandOption(['u', 'p'])
            .argv;
var driver = new webdriver.Builder()
  .forBrowser('chrome')
  .build();

driver.manage().window().setSize(1500, 1000);

console.log(chalk.blue('This tool is in beta, and may have bugs. if you have any problems try restarting the tool, and contacting DusterTheFirst'));
console.log(chalk.red('THIS TOOL ONLY WORKS IF YOU LOGGED OFF WITH ONLY A HARD HAT ON'));
console.log(chalk.red('IF YOU NEED TO STOP THE TOOL TO FIX YOUR PENGUIN, TYPE CTRL+C'));
console.log(chalk.blue('AVOID INTERFERING WITH THE TOOL WHILE IT RUNS'));

let uname = args.username;
let pass = args.password;

driver.get('https://play.clubpenguinrewritten.pw/').then(() => {
    driver.findElement({id:"notification-close"}).click().then(() => {
        driver.findElement({id: "cp_flash"}).then((elem) => {
            if (args.dev) {
                driver.executeScript(() => {
                    //#region Mouse Position
                    let mousepos = document.createElement("div");
                    mousepos.style.position = 'absolute';
                    mousepos.style.top = '0';
                    mousepos.style.left = '0';
                    mousepos.style.backgroundColor = 'black';
                    mousepos.style.transform = 'translate(-50%, -50%)';
                    mousepos.style.pointerEvents = 'none';
                    mousepos.style.whiteSpace = 'nowrap';
                    mousepos.innerHTML = "MOUSE BE HERE";
                    //#endregion
                    document.body.style.overflowX = 'hidden';
                    document.body.appendChild(mousepos);
                    document.onmousemove = (e) => {
                        mousepos.style.top = e.pageY;
                        mousepos.style.left = e.pageX;
                        var x = e.pageX;
                        var y = e.pageY;
                        window.location.hash = `(${x},${y})`;
                    }
                });
            }
            waitForPixel(1200, 500, 3422552319, () => {
                elem.click();
                driver.actions()
                      .mouseMove({x: 0, y: 300})
                      .click()
                      .mouseMove({x: 0, y: -550})
                      .click()
                      .sendKeys(uname)
                      .mouseMove({x: 0, y: 50})
                      .click()
                      .sendKeys(pass)
                      .perform();
                elem.click();
                waitForPixel(1235, 525, 4175107839, () => {
                    elem.click();
                    driver.actions().mouseMove({x: 500, y: 100}).click().perform();
                    elem.click();
                    driver.actions().mouseMove({x: -100, y: -200}).click().perform();
                    waitForPixel(1288, 130, 4106504447, () => {
                        driver.actions().mouseMove({x: -480, y: 530}).click().perform();
                        waitForPixel(1019, 717, 4209271039, () => {
                            driver.actions().mouseMove({x: 700, y: -500}).click().perform();
                            waitForPixel(1288, 130, 4106504447, () => {
                                elem.click();
                                waitForPixel(746, 160, 2946124287, () => {
                                    driver.actions().mouseMove({x: 0, y: -200}).click().perform();
                                    waitForPixel(340, 340, 2459067647, () => {
                                        let count = 0;
                                        setInterval(() => {
                                            if (count % 2 === 0) {
                                                elem.click();
                                                driver.actions().mouseMove({x: -200, y: 100}).click().perform();
                                                driver.actions().mouseMove({x: -150, y: 270}).click().perform();
                                                waitForPixel(425, 531, 4294967295, () => {
                                                    driver.actions().mouseMove({x: 0, y: -300}).click().perform();
                                                    //driver.actions().sendKeys('d').perform();
                                                });
                                            } else {
                                                elem.click();
                                                driver.actions().mouseMove({x: -200, y: 200}).click().perform();
                                                driver.actions().mouseMove({x: -150, y: 170}).click().perform();
                                                waitForPixel(425, 531, 4294967295, () => {
                                                    driver.actions().mouseMove({x: 0, y: -300}).click().perform();
                                                    //driver.actions().sendKeys('d').perform();
                                                });
                                            }
                                            //console.log(count);
                                            count ++;
                                        }, 15000);
                                    });
                                });
                            });
                        });
                    });
                });
            });
            // setInterval(() => {
            //     getPixelColor(935, 500, (hex) => {
            //         console.log(hex);
            //     });
            // }, 100);
        });
    });
});

/**
 * Wait for a pixel to  change to a color
 * @param {number} x X position
 * @param {number} y Y position
 * @param {number} color Hex color to wait for
 * @param {() => void} callback Calls once the pixel matches the given color
 */
function waitForPixel(x, y, color, callback) {
    let interval = setInterval(() => {
        getPixelColor(x, y, (hex) => {
            if (hex === color) {
                clearInterval(interval);
                callback();
            }
        });
    }, 1000);
}

/**
 * Get the color of a pixel
 * @param {number} x X position
 * @param {number} y Y position
 * @param {(hex: number) => void} callback Calls when the pixel has been read
 */
function getPixelColor(x, y, callback) {
    driver.takeScreenshot().then((value) => {
        jimp.read(new Buffer(value, 'base64')).then((img) => {
            img.getPixelColor(x, y, (err, hex) => {
                callback(hex);
            });
        });
    });
}