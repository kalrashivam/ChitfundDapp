// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;


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

    function joinPool() public {
        require(currentMembers < maxMembers, 'Pool is already full');
        require(!poolMembers[msg.sender].hasJoined,
                'You are already a member of the pool');

        poolMembers[msg.sender].hasJoined = true;
        currentMembers++;
    }

    function addfunds() public payable {
        require(poolMembers[msg.sender].hasJoined,
                'You are not a member of this pool');
        require(msg.value == installmentValue,
                'installment amount is not equal to installment value');

        transferFrom(msg.sender, )
        poolMembers[msg.sender].installmentCount++;

    }
}

