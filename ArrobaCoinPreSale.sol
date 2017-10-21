pragma solidity ^0.4.11;

import "./ArrobaCoin.sol";

contract ArrobaCoinPreSale {
    ArrobaCoin public token;
    address public beneficiary;
    uint public amountRaised;
    uint public bonus;

    uint constant public price = 40000000;
    uint constant public minSaleAmount = 1000000000;

    function ArrobaCoinPreSale(
        ArrobaCoin _token,
        address _beneficiary,
        uint _bonus
    ) {
        token = ArrobaCoin(_token);
        beneficiary = _beneficiary;
        bonus = _bonus;
    }

    function () payable {
        uint amount = msg.value;
        uint tokenAmount = amount / price;
        if (tokenAmount < minSaleAmount) throw;
        amountRaised += amount;
        token.transfer(msg.sender, tokenAmount * (100 + bonus) / 100);
    }

    function WithdrawETH(uint _amount) {
        require(msg.sender == beneficiary);
        msg.sender.transfer(_amount);
    }

    function WithdrawTokens(uint _amount) {
        require(msg.sender == beneficiary);
        token.transfer(beneficiary, _amount);
    }

    function TransferTokens(address _to, uint _amount) {
        require(msg.sender == beneficiary);
        token.transfer(_to, _amount);
    }

    function ChangeBonus(uint _bonus) {
        require(msg.sender == beneficiary);
        bonus = _bonus;
    }
}