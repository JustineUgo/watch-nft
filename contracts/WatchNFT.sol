// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract WatchNFT is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Watch NFT", "WNFT") {}

    uint256 owners = 0;

    struct WatchItem {
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    mapping(uint256 => WatchItem) private watches;

    function safeMint(string memory uri, uint256 price)
        public
        payable
        returns (uint256)
    {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(msg.sender, tokenId);

        _setTokenURI(tokenId, uri);
        createWatch(tokenId, price);
        // setApprovalForAll(msg.sender, true);

        return tokenId;
    }

    function makeTransfer(
        address from,
        address to,
        uint256 tokenId
    ) public {
        
        _transfer(from, to, tokenId);
        watches[tokenId].owner = payable(to);
        owners++;
    }

    function createWatch(uint256 tokenId, uint256 price) private {
        require(price > 0, "Price must be at least 1 wei");
        watches[tokenId] = WatchItem(
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false
        );

        _transfer(msg.sender, address(this), tokenId);
    }

    function buyWatch(uint256 tokenId) public payable {
        uint256 price = watches[tokenId].price;
        address seller = watches[tokenId].seller;
        require(
            msg.value >= price,
            "Please submit the asking price in order to complete the purchase"
        );
        watches[tokenId].owner = payable(msg.sender);
        watches[tokenId].sold = true;
        watches[tokenId].seller = payable(address(0));
        _transfer(address(this), msg.sender, tokenId);

        payable(seller).transfer(msg.value);
    }

    function sellWatch(uint256 tokenId) public payable {
        require(
            watches[tokenId].owner == msg.sender,
            "Only item owner can perform this operation"
        );
        watches[tokenId].sold = false;
        watches[tokenId].seller = payable(msg.sender);
        watches[tokenId].owner = payable(address(this));

        _transfer(msg.sender, address(this), tokenId);
    }

    function getWatch(uint256 tokenId) public view returns (WatchItem memory) {
        return watches[tokenId];
    }

    function getWatchLength() public view returns (uint256) {
        return _tokenIdCounter.current();
    }

    function getOwners() public view returns (uint256) {
        return owners;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
