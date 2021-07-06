// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import { FriendPool } from "./FriendPool.sol";

contract solidity {
    function createPool(uint _totalMembers, uint _targetAmount) public returns (uint256) {
        require(poolMember[msg.sender].exists, "Existing pool memeber cannot be an owner");
        poolId++;
        Pools[poolId] = Pool(_totalMembers, _targetAmount);
        poolOwner[poolId] = msg.sender;
        poolMember[msg.sender] = data(true, poolId);

        return poolId;
    }
}
