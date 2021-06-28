// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import { ILendingPool } from "@aave/protocol-v2/contracts/interfaces/ILendingPool.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FriendPool {
    uint maxMembers;
    string poolName;
    address poolOwner;
    uint noOfPayments;
    uint installmentValue;
    uint currentMembers;

    struct Member {
        bool hasJoined;
        uint256 installmentCount;
        bool hasReachedLimit;
    }

    mapping (address => Member) poolMembers;

    modifier hasAlreadyReachedLimit() {
        require(!poolMembers[msg.sender].hasReachedLimit,
                'You have already recieved funds');
        _;
    }

    address private AaveToken = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;
    address private daiAddress = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    IERC20 daiToken = IERC20(daiAddress);

    constructor(
        address _owner,
        string memory _poolName,
        uint _maxMembers,
        uint _noOfPayments,
        uint _installmentValue
    ) {
        maxMembers = _maxMembers;
        poolName = _poolName;
        noOfPayments = _noOfPayments;
        installmentValue = _installmentValue;
        poolOwner = _owner;
    }

    function joinPool() hasAlreadyReachedLimit() public {
        require(currentMembers < maxMembers, 'Pool is already full');
        require(!poolMembers[msg.sender].hasJoined,
                'You are already a member of the pool');

        poolMembers[msg.sender].hasJoined = true;
        currentMembers++;
    }

    function addfunds(uint amount) hasAlreadyReachedLimit() external {
        require(poolMembers[msg.sender].hasJoined,
                'You are not a member of this pool');
        require(amount == installmentValue,
                'installment amount is not equal to installment value');

        // daiToken.transferFrom(msg.sender, address(this), amount);
        ILendingPool(AaveToken).deposit(diaAddress, amount, msg.sender, '0');
        poolMembers[msg.sender].installmentCount++;

    }
}

