//
//  ContentView.swift
//  ToDoListOfYandex_SMD
//
//  Created by Vika on 19.06.2024.
//




import SwiftUI


struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var domany: FileCatche = FileCatche()
    @State private var showingPlusDo = false
    @State private var showIsDone = false
    
    
    var body: some View {
        NavigationStack{
            //MARK: Заголовоки
            HStack(alignment: .bottom) {
                Text("Выполнено - \(domany.todoItems.filter{ $0.isDone}.count)")
                    .padding(.leading)
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {
                    showIsDone.toggle()
                }){
                    Text(showIsDone ? "Скрыть" : "Показать")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.trailing)
                }
            }
            
            List{
                Section {
                    ForEach(domany.todoItems, id: \.id){ item in
                        
                        if showIsDone || (!showIsDone && !item.isDone){
                            
                            
                            HStack{
                                
                                // MARK: Кружочек выполнения
                                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(item.isDone ? .green : (item.priority == .high ? .red : .gray))
                                    .background(
                                        Circle()
                                            .fill(item.priority == .high ? .red.opacity(0.1) : .clear)
                                    )
                                    .gesture(
                                        TapGesture().onEnded {
                                            domany.updateToDoItem(id: item.id, newText: item.text, newIsDone: !item.isDone, newColor: item.color )
                                            
                                        }
                                    )
                                
                                
                                // MARK: Отображение приоритености и текста
                                VStack(alignment: .leading, spacing: 3) {
                                    HStack{
                                        Text(item.priority.rawValue)
                                            .foregroundColor(.gray)
                                        Text(item.text)
                                            .lineLimit(3)
                                            .strikethrough(item.isDone ? true : false)
                                            //.foregroundColor(colorScheme == .dark ? .white : .black)

                                            .foregroundColor(item.isDone ? .gray: (colorScheme == .dark ? .white : .black))
                                    }
                                    
                                    
                                    // MARK: Отображение дедлайна
                                    HStack{
                                        if let deadlineDate = item.deadline {
                                            let calendar = Calendar.current
                                            let today = calendar.startOfDay(for: Date())
                                            let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
                                            if calendar.startOfDay(for: deadlineDate) != tomorrow {
                                                Image(systemName: "calendar")
                                                    .resizable()
                                                    .foregroundColor(.gray)
                                                    .frame(width: 16, height: 16)
                                                Text(formatDateShort(deadlineDate))
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        
                                    }
                                }
                                
                                // MARK: Отображение цвета и перехода на другую страницу
                                Spacer()
                                Color(item.color)
                                    .frame(width: 15, height: 15)
                                
                                    .clipShape(Circle())
                                
                                Button{
                                    
                                }label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                    
                                }
                            }
                            
                            
                            // MARK: Свайпы дела
                            .swipeActions(edge: .leading){
                                Button{
                                    domany.updateToDoItem(id: item.id, newText: item.text, newIsDone: !item.isDone, newColor: item.color )
                                } label:{
                                    Image(systemName: "checkmark.circle.fill")
                                }.tint(.green)
                                
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    domany.remove(id: item.id)
                                } label: {
                                    Image(systemName: "trash")
                                    
                                }.tint(.red)
                                Button{
                                    
                                }label: {
                                    Image(systemName: "info.circle")
                                }
                            }
                        }
                        //
                    }
                    
                    
                    //MARK: Строчка Новое
                    Button(
                        action: {
                            showingPlusDo.toggle()
                            
                        }, label: {
                            Text("Новое")
                                .foregroundStyle(.gray)
                                .padding(10)
                        })
                }
                
            }
            .navigationBarTitle("Мои дела \u{1F9B9}")
            
            
            
            
            //MARK: Кнопка Плюс
            .overlay(alignment: .bottom) {
                Button {
                    showingPlusDo = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
            }
            .sheet(isPresented: $showingPlusDo) {
                AddView(domany: self.domany)
            }
            
            
            
        }
        
    }
    
    
}

#Preview {
    MainView()
}
