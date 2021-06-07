// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

contract TargetMoneyClub {
    uint256 poolId;

    struct Pool {
        uint256 totalmembers;
        uint256 targetAmount;
    }

    mapping (uint256 => address) poolOwner;
    mapping (address => uint256) poolMember;
    mapping (uint256 => Pool) Pools;

    function createPool(uint _totalMembers, uint _targetAmount) public returns (uint256) {
        require(pool);
        poolId++;
        Pools[poolId] = Pool(_totalMembers, _targetAmount);
        poolOwner[poolId] = msg.sender;
        poolMember[msg.sender] = poolId;

        return poolId;
    }
}

