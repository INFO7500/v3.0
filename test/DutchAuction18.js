var BigNumber = require('bignumber.js');
var run = require('./framework.js');

contract('Dutch Auction', function (accounts) {

    it("Refund bid amount", function (done) {
      run(accounts, done, {
        type:                "dutch",
        reservePrice:        500,
        judgeAddress:        accounts[3],
        biddingTimePeriod:   10,
        offerPriceDecrement: 25,
        actions: [
            {block: 11, action: "refund", account: 3,    refundAmount: 750, succeed: false, on_error: "finalize rejected"},
          { block: 15, action: "refund", account: 2, finalized:false, refundAmount: 725, succeed: false, on_error: "Refund bid amount" },

    ],
      });
    });
});