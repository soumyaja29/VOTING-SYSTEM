// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;

    uint public candidatesCount;

    event VoteCast(uint indexed candidateId);

    constructor() {
        // Add default candidates
        addCandidate("Alice");
        addCandidate("Bob");
    }

    function addCandidate(string memory name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0);
    }

    function vote(uint candidateId) public {
        require(!voters[msg.sender], "Already voted!");
        require(candidateId > 0 && candidateId <= candidatesCount, "Invalid candidate!");

        voters[msg.sender] = true;
        candidates[candidateId].voteCount++;

        emit VoteCast(candidateId);
    }

    function getCandidate(uint candidateId) public view returns (Candidate memory) {
        require(candidateId > 0 && candidateId <= candidatesCount, "Invalid candidate!");
        return candidates[candidateId];
    }
}
