// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SonovateINFT is ERC721Enumerable, Ownable {
    uint256 public constant MAX_SUPPLY = 1000;
    uint256 public nextTokenId = 1;

    // Mapping from token ID to token metadata
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("Sonovate iNFT", "SOV") {}

    // Mint a new iNFT token
    function mint(address to, string memory tokenURI) external onlyOwner {
        require(nextTokenId <= MAX_SUPPLY, "Maximum supply reached");
        _safeMint(to, nextTokenId);
        _setTokenURI(nextTokenId, tokenURI);
        nextTokenId++;
    }

    // Override base class function to set token URI
    function _setTokenURI(uint256 tokenId, string memory uri) internal virtual {
        require(_exists(tokenId), "Token ID does not exist");
        _tokenURIs[tokenId] = uri;
    }

    // Return the token URI for a given token ID
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "Token ID does not exist");
        return _tokenURIs[tokenId];
    }
}
