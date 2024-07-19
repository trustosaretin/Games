// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
 
import "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";

 
contract PriceFeed {

    mapping(address => bytes32) public s_priceFeeds;
    mapping(address => bool) public s_isLoanable;
    bytes32  [] public pricefeed;
    address [] public collateralToken; 
    IPyth pyth;
    uint256 public total = 0;

    uint256 constant NEW_PRECISION = 1e10;
    uint256 constant PRECISION = 1e18;



  constructor(
    address pythContract,
    bytes32 [] memory _pricefeed,
   address [] memory _tokens) {

    pyth = IPyth(pythContract);
    
    if(_pricefeed.length != _tokens.length) revert("invalid tokens inserted");
    for(uint i = 0; i < _pricefeed.length; i++){
        if(_tokens[i] != address(0)){
               s_isLoanable[_tokens[i]] = true;
            collateralToken[i] = _tokens[i];
            s_priceFeeds[_tokens[i]] = _pricefeed[i];
        }
    }
  }

    function getUsdValue(
        address _token,
        uint256 _amount
    ) public returns (uint256) {
        bytes32 feedId = s_priceFeeds[_token];
        if(feedId == bytes32(0)) revert ("Protocol__InvalidToken");

        PythStructs.Price memory _priceStruct = pyth.getPrice(feedId);
    
        uint256 price = uint256(int256(_priceStruct.price));
        if (_priceStruct.price < 0) revert("Protocol__NegativePrice");
        total = ((price * NEW_PRECISION) * _amount) / PRECISION;
        return total;

    }

    /// @dev For adding more tokens that are loanable on the platform
    /// @param _token the address of the token you want to be loanable on the protocol
    /// @param _priceFeed the address of the currency pair on chainlink
    function addLoanableToken(
        address _token,
        bytes32 _priceFeed
    ) external  {
        s_isLoanable[_token] = true;
        s_priceFeeds[_token] = _priceFeed;
        collateralToken.push(_token);
    }




}