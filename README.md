# Equalis

**_Arjun Sarao, Bram Ogus, Connor Wilson, Rene Gonzalez Pina_**

## 💡 Inspiration

We want to create a system that would help eliminate voter fraud and allow citizens to quickly and efficiently participate in not only their electoral system but their legislative one too. Using the blockchain would help because all voters would be signed with a UUID consisting of the hash of their health card number, passport number, and a special QR Code sent to the voter's address via mail.

## 📱 What it does

Users sign up by scanning their passport, health card, and a special QR Code sent to them by us. They can then participate in governmental elections as well as in passing legislation. Equalis uses the blockchain for storing election information. All votes are signed with a hash of a voter's health card number, passport number, and a special QR Code sent to the voter's address via mail. The home screen contains upcoming laws as well as a countdown to the next election. On the laws page, users are able to scroll through a list of all laws both passed and not and are presented with an AI-generated summary, followed by important dates, and then the full law itself. The user would then be prompted to either vote for or against the law. When there is not an election going on, the elections page would simply be displaying a countdown, when the election is live, voters can select their preferred candidates.

### 📃 Full Feature List

- Identity verification using OCR and face recognition
- AI-generated legislation summary
- Election vote counts stored on Blockchain via proof of works
- Interactive graphs for vote breakdown for laws and elections

## 🛠 How we built it

- **Adobe XD**: We designed the mockups in Adobe XD to figure out the UI/UX and the general flow of the app
- **Flutter**: We built the frontend in Flutter using XYZ packages
- **Python**: Python was used for our backend/API as well as for our ML components
  - `transformers`: We used the HuggingFace package, specifically Google's _Pegasus_ model to summarize the legislative documents
  - `face_recognition`: This Python package was used to measure the similarity between a user's passport photo and another photo
  - `firebase_admin`: Firebase SDK for Python
  - `web3.py`: Used to interact with the Solidity smart contract on the blockchain
  - `py-solc-x`: For compiling the Solidity code
  - `pytesseract`: We used pytesseract for the passport verification by reading MRZ's (Machine Readable Zones)
  - `flask`: Used to host our JSON API on the web
- **Firebase**: We also made our backend with Firebase to hold the user data (name, UUID, privilege, votes sent, ect.)
- **Solidity**: Solidity was used to create the smart contract on the blockchain

## 🛑 Challenges we ran into

- Smart Contract development
- Making sure the OCR packages were able to run on repl.it
- Having Python interact with the blockchain
- Figuring out what information to store in a database vs. the blockchain

## ✅ Accomplishments that we're proud of

- Implementing a full smart contract with no previous knowledge of Solidity
- Getting it all working, lol
- Connecting our app to Rinkeby TestNet
  
## 📖 What we learned

- Solidity
- `flask`
- `web3.py`, `py-solc-x`
- `firebase_admin`
- `pytesseract`, `face-recognition`, `transformers`

## 🤔 What's next for Equalis

- Refine the user authentication process
- Create more robust tooling for creating elections
- Add more forms of verification in case people don't have their passports handy
- Deploy the smart contract to MainNet or on-premise Private Network
- Refine the law summarization

## Tech Stack

![techstack](https://user-images.githubusercontent.com/47152801/149667898-8c61a6a6-eb78-4244-9529-3a7fd1aace1e.png)

## 🖼 Gallery

## 💻 Lines of Code
- 389 lines of Python Code
- 213 lines of Solidity Code
- X lines of Flutter
## 🙇‍♂️ Acknowledgements

We would like to thank DeltaHacks for the opportunity to create and develop our idea.
