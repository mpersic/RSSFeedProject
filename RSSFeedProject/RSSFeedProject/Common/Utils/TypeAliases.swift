//
//  TypeAliases.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Foundation

typealias EmptyCallback = () -> Void
typealias ArgCallback<T> = (T) -> Void
typealias UUIDCallback = (UUID) -> Void
typealias Callback<T> = (T) -> Void

typealias ErrorCallback = (Error) -> Void
typealias DismissWithCallback = (EmptyCallback?) -> Void
