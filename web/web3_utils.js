// web3_utils.js
async function checkWeb3Provider() {
  if (typeof window.ethereum !== 'undefined') {
    return true;
  } else {
    alert('Molimo instalirajte MetaMask!');
    return false;
  }
}
//OVO NAM JE PRAVILO PROBLEME
async function loadContract() {
  const response = await fetch('assets/abi.json');
  const abi = await response.json();

  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();

  const contractAddress = '0x63539CF43cE777c6DfAdBE484De53246cE7eF134'; //MOJ UGOVOR?
  const contract = new ethers.Contract(contractAddress, abi, signer);

  return contract;
}

async function requestAccount() {
  try {
    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
    return accounts[0];
  } catch (error) {
    console.error("Došlo je do greške prilikom zahteva za pristup nalogu:", error);
    throw error;
  }
}

async function checkNetwork() {
  if (window.ethereum) {
    const chainId = await window.ethereum.request({ method: 'eth_chainId' });
    // Binance Smart Chain Testnet (0x61) or Mainnet (0x38)
    return chainId === '0x61' || chainId === '0x38';
  }
  return false;
}

//Hvala Tamara (gleda adresu, učitava ABI, pasira amount, vraća hash transakc)
async function sendTransaction(bnbAmount) {
  try {
    if (!window.ethereum.selectedAddress) {
      await requestAccount();
    }

    const contract = await loadContract(); // koristi tvoj `loadContract` koji si već napisala  

    const tx = await contract.buyTokens({
      value: ethers.utils.parseEther(bnbAmount.toString())
    });

    return tx.hash;
  } catch (error) {
    console.error("Greška pri pozivu funkcije buyTokens:", error);
    throw error;
  }
}


// Expose functions to window
window.checkWeb3Provider = checkWeb3Provider;
window.requestAccount = requestAccount;
window.checkNetwork = checkNetwork;
window.sendTransaction = sendTransaction;




/* ZBOG OVOGA SAM  PSIHIČKI LABILNIJI NEGO INAČE 
async function sendTransaction(bnbAmount) {
  try {
    // Check if connected to MetaMask
    if (!window.ethereum.selectedAddress) {
      await requestAccount();
    }

    // Convert BNB amount to wei (1 BNB = 10^18 wei)
    const weiAmount = ethers.utils.parseEther(bnbAmount.toString()).toHexString();

    const transactionParameters = {
      to: '0x757be8f26d34b3e2b5aa79afb728c26e6e2770ee', // Your contract address
      from: window.ethereum.selectedAddress,
      value: weiAmount,
      // You can add gas parameters if needed
      // gas: '0x5208', // 21000 wei
      // gasPrice: '0x3b9aca00' // 1 gwei
    };

    // Send the transaction
    const txHash = await window.ethereum.request({
      method: 'eth_sendTransaction',
      params: [transactionParameters],
    });*

    return txHash;
  } *
    catch (error) {
    console.error("Greška prilikom slanja transakcije:", error);
    throw error;
  }
}*/