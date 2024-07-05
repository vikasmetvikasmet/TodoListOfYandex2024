//
//   AddView.swift
//  ToDoListOfYandex_SMD
//
//  Created by Vika on 26.06.2024.
//
import SwiftUI



struct AddView: View {
    @Environment(\.presentationMode)
    var presentationMode
    
    @ObservedObject var domany: FileCatche
    @State private var text = ""
    @State private var type = "нет"
    @State private var priority: TodoItem.Priority = .normal
    @State private var createdAt = Date()
    @State private var deadline = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State var selectedColor = Color(red: 1, green: 1, blue: 1)
    @State private var sharingToggle = false
    @State private var showCalander = false
    
    var body: some View {
        NavigationView{
            Form{
                
                //MARK: Ввод дела
                Section{
                    ZStack(alignment: .topTrailing){
                        TextField("Что нужно сделать?", text: $text, axis: .vertical)
                            .padding(.bottom, 50)
                            .lineLimit(100)
                        Spacer()
                        Rectangle()
                            .offset(x: 10)
                            .frame(width: 5)
                            .foregroundColor(selectedColor)
                    }
                    
                }
                
                //MARK: Выбор важности дела
                Section {
                    HStack{
                        Text("Важность")
                        Spacer()
                        Picker("", selection: $priority){
                            Text("\u{2193}")
                                .tag(TodoItem.Priority.low)
                            Text("нет")
                                .tag(TodoItem.Priority.normal)
                            Text("\u{203C}")
                                .tag(TodoItem.Priority.high)
                        }
                        .pickerStyle(.segmented)
                        .scaledToFit()
                        
                    }
                    
                    
                    //MARK: Дедлайн
                    Toggle(isOn: $sharingToggle){
                        VStack(alignment: .leading){
                            Text("Сделать до")
                            if sharingToggle == true{
                                
                                Text(formatDateLong(deadline))
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        withAnimation {
                                            showCalander.toggle()
                                        }
                                    }
                            }
                        }
                    }
                    if sharingToggle && showCalander {
                        DatePicker("Выберите дату", selection: $deadline, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                }
                
                //MARK: Выбор цвета
                HStack{
                    VStack(alignment: .leading){
                        Text("Цвет")
                        Text(selectedColor.toHex)
                    }
                    ColorPicker("", selection: $selectedColor)
                }
                 
                
                //MARK: Удалить дело
                Section {
                    HStack {
                        Spacer()
                        Button("Удалить") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundStyle(Color.red)
                        .font(.system(size: 20))
                        .padding(10)
                        Spacer()
                    }
                }
                
                
            //MARK: Заголвок
            }.navigationBarTitle("Дело века", displayMode: .inline)
            
            
            //MARK: Кнопки перехода в заголовке
                .navigationBarItems(trailing: Button("Сохранить"){
                    if self.text != "" {
                        
                        let item = TodoItem(text: self.text, deadline: self.deadline, createdAt: self.createdAt, priority: self.priority, color: self.selectedColor)
                        
                        self.domany.add(item)
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
                }
                    .foregroundColor(self.text.isEmpty ? .gray : .blue)
                )
                .navigationBarItems(leading: Button("Отменить"){
                    self.presentationMode.wrappedValue.dismiss()
                    
                })
        }
        
    }
}

#Preview {
    AddView(domany: FileCatche())
}






