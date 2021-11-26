//
//  ContentView.swift
//  Password Manager Design
//
//  Created by Luke Drushell on 11/22/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var password = ""
    @FocusState var keyboardShown: Bool
    @State private var search = ""
    @State private var displayedURL = "Please Login..."
    @State private var showPasswords = false
    @State private var isUnlocked = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Image("Background")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    .blur(radius: 2)
                if password != "password123" {
                    VStack {
                        Text("Your browser, done right.")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 25)
                            .padding(.top, -80)
                            .multilineTextAlignment(.center)
                        TextField("Enter Password to Begin...", text: $password)
                            .padding()
                            .background(.regularMaterial)
                            .cornerRadius(15)
                            .padding()
                            .focused($keyboardShown)
                            .disableAutocorrection(true)
                            .keyboardType(.asciiCapable)
                        
                    }
                } else {
                    VStack {
                        Text("Your browser, done right.")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 25)
                            .padding(.top, -80)
                            .multilineTextAlignment(.center)
                            .onAppear(perform: {
                                displayedURL = "https://google.com"
                            })
                        TextField("Search Google or type a URL", text: $search)
                            .overlay(alignment: .trailing, content: {
                                if 25 > search.count {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .frame(width: 20, height: 20, alignment: .center)
                                        .foregroundColor(Color(uiColor: .lightGray))
                                }
                            })
                            .padding()
                            .background(.regularMaterial)
                            .cornerRadius(15)
                            .padding()
                            .focused($keyboardShown)
                            .disableAutocorrection(true)
                            .keyboardType(.asciiCapable)
                    }
                }
            } .toolbar(content: {
                ToolbarItem(placement: .keyboard, content: {
                    HStack {
                        Spacer()
                        if displayedURL == "Please Login..." {
                        Spacer()
                            Divider()
                            Button {
                                showPasswords = true
                            } label: {
                                Text("Passwords")
                                    .foregroundColor(Color(UIColor.lightGray))
                                    .font(.title3)
                            }
                            Divider()
                            Spacer()
                        }
                        Button {
                            keyboardShown = false
                        } label: {
                            Text("Done")
                        }
                    }
                })
            })
                .sheet(isPresented: $showPasswords, onDismiss: {
                    isUnlocked = false
                }, content: {
                    NavigationView {
                        VStack {
                            if isUnlocked == false {
                                Button {
                                    authenticate()
                                } label: {
                                    Text("FaceID Failed, Tap to Try Again")
                                }
                            } else {
                                Divider()
                                Section(content: {
                                    Button {
                                        showPasswords = false
                                        password = "password123"
                                    } label: {
                                    HStack {
                                        Text("BrowserSafe")
                                            .padding()
                                        Spacer()
                                        Image(systemName: "app.connected.to.app.below.fill")
                                            .resizable()
                                            .frame(width: 18, height: 24, alignment: .center)
                                            .padding()
                                    } .frame(width: UIScreen.main.bounds.width * 0.75, height: 40, alignment: .center)
                                        .background(.regularMaterial)
                                        .cornerRadius(20)
                                        .padding(.horizontal)
                                    }
                                }, header: {
                                    Text("For this Page")
                                })
                                Divider()
                                Section(content: {
                                    ForEach(0...10, id: \.self, content: { _ in
                                        Button {
                                            showPasswords = false
                                            password = "password1234"
                                        } label: {
                                            HStack {
                                                Text("Another Cool Site")
                                                    .padding()
                                                Spacer()
                                                Image(systemName: "key.fill")
                                                    .resizable()
                                                    .frame(width: 12, height: 24, alignment: .center)
                                                    .padding()
                                            } .frame(width: UIScreen.main.bounds.width * 0.75, height: 40, alignment: .center)
                                                .background(.regularMaterial)
                                                .cornerRadius(20)
                                                .padding(.horizontal)
                                        }
                                    })
                                }, header: {
                                    Text("Others")
                                })
                            }
                        } .navigationTitle("Passwords")
                            .onAppear(perform: {
                                authenticate()
                            })
                    }
                })
        }
        .edgesIgnoringSafeArea(.all)
        .overlay(alignment: .bottom, content: {
            if keyboardShown != true || keyboardShown {
                VStack(spacing: 20) {
                    HStack(spacing: 30) {
                        Button {
                            
                        } label: {
                            Image(systemName: "puzzlepiece.extension")
                                .font(.headline.bold())
                        }
                        Button {
                            
                        } label: {
                            Text("\(displayedURL)")
                                .padding()
                                .truncationMode(.tail)
                                .frame(width: UIScreen.main.bounds.width * 0.7, height: 40, alignment: .center)
                                .background(.thickMaterial)
                                .cornerRadius(15)
                        }
                        .padding(.vertical, -5)
                        .padding(.horizontal, -15)
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .font(.title3.bold())
                        }
                    } .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
                        .padding(.top, -10)
                    HStack(spacing: 45) {
                        Button {
                            
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "book")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "square.on.square")
                                
                        }
                    }
                    .padding(.top, -20)
                    .font(.title3.bold())
                }
                .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center)
                .background(.regularMaterial)
                .offset(y: keyboardShown ? 250 : 0)
            }
        })
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // there was a problem
                    }
                }
            }
        } else {
            // no biometrics
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
