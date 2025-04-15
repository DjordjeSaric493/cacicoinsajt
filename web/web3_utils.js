async function checkWeb3Provider() {
  if (typeof window.ethereum !== 'undefined') {
    return true;
  } else {
    alert('Molimo instalirajte MetaMask!');
    return false;
  }
}

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

async function sendTransaction(bnbAmount) {
  try {
    if (!window.ethereum.selectedAddress) {
      await requestAccount();
    }

    const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
    const contractAddress = '0x63539CF43cE777c6DfAdBE484De53246cE7eF134'; //MOJ UGOVOR?

    if (isMobile) {
      const amountToSendWei = ethers.utils.parseEther(bnbAmount.toString()).toHexString();
      const deepLink = `https://metamask.app/send?to=${contractAddress}&value=${amountToSendWei}`;
      window.location.href = deepLink;
      alert('MetaMask aplikacija se otvara. Molimo vas da potvrdite kupovinu.');
      return 'mobile_transaction_initiated';
    } else {
      const contract = await loadContract();
      const tx = await contract.buyTokens({
        value: ethers.utils.parseEther(bnbAmount.toString())
      });
      return tx.hash;
    }
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