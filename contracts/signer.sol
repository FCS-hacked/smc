// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Signer {
    event Signed(address signer, uint256 file);

    mapping (address => uint256[]) public signed_files;

    mapping (uint256 => address[]) public file_signers;


    mapping (uint256 => address) public directory;

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

    function get_file_signers(uint256 file) external view returns (address [] memory signers) {
        return file_signers[file];
    }

    function get_signed_files(address ad) external view returns (uint256 [] memory files) {
        return signed_files[ad];
    }

    function write_directory(uint256 hash) external {
        directory[hash] = msg.sender;
    }

    function read_directory(uint256 hash) external view returns (address) {
        return directory[hash];
    }
}
