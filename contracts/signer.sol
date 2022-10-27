// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Signer {
    event Signed(address signer, uint256 file);

    mapping (address => uint256[]) public signed_files;

    mapping (uint256 => address[]) public file_signers;

    function sign(uint256 file) external {
        signed_files[msg.sender].push(file);
        file_signers[file].push(msg.sender);
        emit Signed(msg.sender, file);
    }

    function check_signature(uint256 file, address signer) external view returns (bool result) {
        uint256[] memory files = signed_files[signer];
        for (uint256 i = 0; i < files.length; i++) {
            if (files[i] == file) {
                return true;
            }
        }
        return false;   
    }

}