// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract JioFaucet is Ownable, Pausable {
    /**
     * @dev the caller of this constructor will become the owner of this contract
     */
    address public usdtToken;
    address public usdcToken;
    address public daiToken;
    
    uint256 public maxAmountPerAddress = 1000000000000000000000; //max amount a user can request
    uint256 public maxAmountToRequest = 100000000000000000000; //default is 100ERC20 tokens

    // mapping(address => uint256) private _maxAllowedBalance;

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function setUsdtToken(address _usdtToken) external onlyOwner {
        usdtToken = _usdtToken;
    }

    function setUsdcToken(address _usdcToken) external onlyOwner {
        usdcToken = _usdcToken;
    }

    function setDaiToken(address _daiToken) external onlyOwner {
        daiToken = _daiToken;
    }

    function setMaxAmountToRequest(uint256 _maxAmountToRequest)
        external
        onlyOwner
    {
        maxAmountToRequest = _maxAmountToRequest;
    }

// Todo 

    function requestdaiToken(uint256 amount)
        external
        payable
        virtual
        whenNotPaused
    {
        require(amount <= maxAmountToRequest, "Sorry : max amount is 100");
        
        IERC20(daiToken).transfer(msg.sender, amount);
    }

    function requestusdtToken(uint256 amount)
        external
        payable
        virtual
        whenNotPaused
    {
  
        require(amount <= maxAmountToRequest, "Sorry : max amount is 100");
        
        IERC20(usdtToken).transfer(msg.sender, amount);
    }

    function requestusdcToken(uint256 amount)
        external
        payable
        virtual
        whenNotPaused
    {
    
        require(amount <= maxAmountToRequest, "Sorry : max amount is 100");
        
        IERC20(usdcToken).transfer(msg.sender, amount);
    }
}
