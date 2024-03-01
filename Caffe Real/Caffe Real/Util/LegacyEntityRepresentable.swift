//
//  LegacyEntityRepresentable.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 3/1/23.
//

import SwiftUI
import RealityKit

struct LegacyEntityRepresentableContext {}

protocol LegacyEntityRepresentable: View {

    associatedtype EntityType: Entity = Entity

    typealias Context = LegacyEntityRepresentableContext

    @preconcurrency @MainActor
    func makeEntity(context: Context) -> EntityType
    
    @preconcurrency @MainActor
    func updateEntity(_ entity: EntityType, context: Context)
}

extension LegacyEntityRepresentable {

    var body: some View {
        RealityView { content in
            content.add(makeEntity(context: .init()))
        } update: { content in
            for entity in content.entities.compactMap({ $0 as? EntityType }) {
                updateEntity(entity, context: .init())
            }
        }
    }
}


