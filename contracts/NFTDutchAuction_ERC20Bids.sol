//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract NFTDutchAuction_ERC20Bids {

    address payable ownerAddress;
    uint256 reservePrice;
    address judgeAddress;
    uint256 numBlocksActionOpen;
    uint256 offerPriceDecrement;
    uint startBlockNumber;
    address payable winnerAddress;
    uint winningBid;
    bool endAuction;
    bool finalized;

    constructor (uint256 _reservePrice, address _judgeAddress, uint256 _numBlocksAuctionOpen, uint256 _offerPriceDecrement
   /* address erc20TokenAddress, address erc721TokenAddress, uint256 _nftTokenId*/)
     {
        // iniitialize everything to a variable
        reservePrice = _reservePrice;
        judgeAddress = _judgeAddress;
        numBlocksActionOpen = _numBlocksAuctionOpen;
        offerPriceDecrement = _offerPriceDecrement;
        ownerAddress = payable(msg.sender);
        startBlockNumber = block.number;
    }

    function bid() public payable returns(address) {
        require(!endAuction);
        require(block.number < (startBlockNumber + numBlocksActionOpen));
        require(msg.value >= (reservePrice + (offerPriceDecrement * (startBlockNumber + numBlocksActionOpen - block.number))));

        endAuction = true;

        if(judgeAddress == address(0x0)){
            ownerAddress.transfer(msg.value);
        }else{
            winnerAddress = payable(msg.sender);
            winningBid = msg.value;
        }
    }

    function finalize() public {
        require(endAuction && !finalized);
        require(msg.sender == judgeAddress || msg.sender == winnerAddress);
        finalized = true;
        ownerAddress.transfer(winningBid);
    }

    function refund(uint256 refundAmount) public {
        require(endAuction && !finalized);
       // require(msg.sender == judgeAddress);
        finalized = true;
        ownerAddress.transfer(refundAmount);
    }

    //for testing framework
    function nop() public returns(bool) {
        return true;
    }
}
