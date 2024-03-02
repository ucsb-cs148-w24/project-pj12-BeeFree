function printMessage() {

    let messageDiv = document.createElement('div');
    messageDiv.style.cssText = 'position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 40px;';
    messageDiv.innerText = 'Hello, World!';


    document.body.appendChild(messageDiv);

    document.querySelector('button').style.display = 'none';

}