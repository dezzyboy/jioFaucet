// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract JioFaucet is Ownable, Pausable, ReentrancyGuard {
    /**
     * @dev the caller of this constructor will become the owner of this contract
     */

    uint256 public constant DAY = 24 * 60 * 60;
    address public usdtToken;
    address public usdcToken;
    address public daiToken;

    uint256 public totalMaxAmount = 10000000000000000000000;
    uint256 public constant DAILY_MAX_AMOUNT = 1000000000000000000000;

    uint256 public maxAmountToRequest = 100000000000000000000; //default is 100ERC20 tokens

    struct User {
        uint256 totalAmount;
        uint256 dailyAmount;
        uint256 lastTxTime;
    }

    mapping(address => User) public userMap;
    event TokenSent(uint256 amount);

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
    function setTotalMaxAmount(uint256 _totalMaxAmount)
        external
        onlyOwner
    {
        totalMaxAmount = _totalMaxAmount;
    }

    function requestDaiToken(uint256 amount)
        external
        payable
        virtual
        nonReentrant
        whenNotPaused
    {
        User storage user = userMap[msg.sender];
        user.totalAmount += amount;
        require(
            user.totalAmount <= totalMaxAmount,
            "request exceeds max total"
        );
        require(amount <= maxAmountToRequest, "Sorry : max amount is 100");
        user.dailyAmount = (block.timestamp / DAY - user.lastTxTime / DAY >= 1)
            ? amount
            : user.dailyAmount + amount;
        require(
            user.dailyAmount <= DAILY_MAX_AMOUNT,
            "request exceed daily max amount"
        );

        user.lastTxTime = block.timestamp;

        IERC20(daiToken).transfer(msg.sender, amount);
        emit TokenSent(amount);
    }

    function requestUsdtToken(uint256 amount)
        external
        payable
        virtual
        nonReentrant
        whenNotPaused
    {
        User storage user = userMap[msg.sender];
        user.totalAmount += amount;
        require(
            user.totalAmount <= totalMaxAmount,
            "request exceeds max total"
        );
        require(amount <= maxAmountToRequest, "Sorry : max amount is 100");
        user.dailyAmount = (block.timestamp / DAY - user.lastTxTime / DAY >= 1)
            ? amount
            : user.dailyAmount + amount;
        require(
            user.dailyAmount <= DAILY_MAX_AMOUNT,
            "request exceed daily max amount"
        );

        user.lastTxTime = block.timestamp;

        IERC20(usdtToken).transfer(msg.sender, amount);
        emit TokenSent(amount);
    }

    function requestUsdcToken(uint256 amount)
        external
        payable
        virtual
        nonReentrant
        whenNotPaused
    {
        User storage user = userMap[msg.sender];
        user.totalAmount += amount;
        require(
            user.totalAmount <= totalMaxAmount,
            "request exceeds max total"
        );
        require(amount <= maxAmountToRequest, "Sorry : max amount is 100");
        user.dailyAmount = (block.timestamp / DAY - user.lastTxTime / DAY >= 1)
            ? amount
            : user.dailyAmount + amount;
        require(
            user.dailyAmount <= DAILY_MAX_AMOUNT,
            "request exceed daily max amount"
        );

        user.lastTxTime = block.timestamp;

        IERC20(usdcToken).transfer(msg.sender, amount);
        emit TokenSent(amount);
    }
}
