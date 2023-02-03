// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Marketplace{
    address payable  owner;
    mapping(uint => uint) public NFTs;
    mapping(uint => uint) public mintedNFTs;
    event Buy(address indexed _from, uint indexed _nftId);
    event Sell(address indexed _to, uint indexed _nftId);

    modifier onlyOwner{
        require(owner == msg.sender);
        _;
    }

    function mintNFT(uint _nftId, uint _price) external onlyOwner{
        NFTs[_nftId] = _price;
        mintedNFTs[_nftId] = 1;
    }
    function BuyNft(uint _nftId) public payable {
        require(NFTs[_nftId] >0, "nfts not available");
        require(msg.value >= NFTs[_nftId]);
        owner.transfer(msg.value);
        mintedNFTs[_nftId]++;
        emit Buy(msg.sender,  _nftId);
    }
    function sellNFT(uint _nftId) public onlyOwner  {
        require(mintedNFTs[_nftId] > 0, "NFT does not exist");
        mintedNFTs[_nftId]--;
        owner.transfer(NFTs[_nftId]);
        emit Sell(msg.sender, _nftId);
    }
    function getOwner() public view returns (address) {
        return owner;
    }
    
}
