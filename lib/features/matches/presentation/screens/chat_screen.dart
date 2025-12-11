import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/providers/theme_provider.dart';
import '../../providers/matches_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String matchId;

  const ChatScreen({super.key, required this.matchId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    _messageController.clear();

    await ref
        .read(chatNotifierProvider(widget.matchId).notifier)
        .sendMessage(content);

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final matchAsync = ref.watch(matchProvider(widget.matchId));
    final messagesAsync = ref.watch(messagesStreamProvider(widget.matchId));
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;
    final variant = ref.watch(themeVariantProvider);
    final primaryColor = getThemePrimaryColor(variant);
    final surfaceColor = getThemeSurfaceColor(variant);
    final backgroundColor = getThemeBackgroundColor(variant);
    final isDark = isThemeDark(variant);
    final cardRadius = getCardBorderRadius(variant);

    return Scaffold(
      appBar: _buildAppBar(context, matchAsync, variant, primaryColor),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                if (messages.isEmpty) {
                  return _buildEmptyChat(variant, primaryColor, isDark);
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == currentUserId;

                    return _buildMessageBubble(
                      context,
                      message,
                      isMe,
                      variant,
                      primaryColor,
                      surfaceColor,
                      cardRadius,
                    );
                  },
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
          _buildMessageInput(
            context,
            variant,
            primaryColor,
            surfaceColor,
            backgroundColor,
            cardRadius,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AsyncValue matchAsync,
    AppThemeVariant variant,
    Color primaryColor,
  ) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          variant == AppThemeVariant.v7HighContrastRed
              ? Icons.arrow_back_ios_new
              : Icons.arrow_back,
        ),
        onPressed: () => context.pop(),
      ),
      title: matchAsync.when(
        data: (match) {
          final otherUser = match?.otherUser;
          return _buildAppBarTitle(context, otherUser, variant, primaryColor);
        },
        loading: () => _buildLoadingTitle(variant),
        error: (_, __) => const Text('Chat'),
      ),
      centerTitle: variant == AppThemeVariant.v5LuxuryGoldBlack,
    );
  }

  Widget _buildAppBarTitle(
    BuildContext context,
    dynamic otherUser,
    AppThemeVariant variant,
    Color primaryColor,
  ) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFF00FF), width: 2),
              ),
              child: otherUser?.photoUrl != null
                  ? CachedNetworkImage(
                      imageUrl: otherUser!.photoUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person, size: 20, color: Color(0xFF00FFFF)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (otherUser?.displayName ?? 'Unknown').toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF00FFFF),
                    letterSpacing: 2,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00FF00),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'ONLINE',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF00FF00),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      case AppThemeVariant.v5LuxuryGoldBlack:
        return Text(
          (otherUser?.displayName ?? 'Chat').toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            letterSpacing: 4,
            color: Color(0xFFD4AF37),
          ),
        );
      case AppThemeVariant.v6PlayfulPastel:
        return Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFF6B9D), width: 2),
              ),
              child: ClipOval(
                child: otherUser?.photoUrl != null
                    ? CachedNetworkImage(
                        imageUrl: otherUser!.photoUrl!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.sentiment_satisfied_alt, size: 20, color: Color(0xFFFF6B9D)),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${otherUser?.displayName ?? 'Chat'} 💬',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF6B9D),
              ),
            ),
          ],
        );
      default:
        return Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor, width: 2),
              ),
              child: ClipOval(
                child: otherUser?.photoUrl != null
                    ? CachedNetworkImage(
                        imageUrl: otherUser!.photoUrl!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.person, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              otherUser?.displayName ?? 'Chat',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        );
    }
  }

  Widget _buildLoadingTitle(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return const Text(
          'LOADING...',
          style: TextStyle(
            color: Color(0xFF00FFFF),
            letterSpacing: 2,
            fontFamily: 'monospace',
          ),
        );
      default:
        return const Text('Loading...');
    }
  }

  Widget _buildEmptyChat(AppThemeVariant variant, Color primaryColor, bool isDark) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF00FFFF), width: 2),
                ),
                child: const Icon(
                  Icons.terminal,
                  size: 50,
                  color: Color(0xFF00FFFF),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '// NO_MESSAGES',
                style: TextStyle(
                  color: Color(0xFF00FFFF),
                  fontSize: 16,
                  letterSpacing: 3,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'INITIATE COMMUNICATION >',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        );
      case AppThemeVariant.v6PlayfulPastel:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B9D).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  size: 50,
                  color: Color(0xFFFF6B9D),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'No messages yet! 💬',
                style: TextStyle(
                  color: Color(0xFFFF6B9D),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Say hello! 👋✨',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 60,
                color: isDark ? Colors.grey[600] : Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No messages yet',
                style: TextStyle(
                  fontSize: 18,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Say hello! 👋',
                style: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[500],
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildMessageBubble(
    BuildContext context,
    dynamic message,
    bool isMe,
    AppThemeVariant variant,
    Color primaryColor,
    Color surfaceColor,
    double cardRadius,
  ) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return _buildNeonMessage(message, isMe);
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryMessage(message, isMe);
      case AppThemeVariant.v6PlayfulPastel:
        return _buildPastelMessage(context, message, isMe);
      case AppThemeVariant.v7HighContrastRed:
        return _buildBoldMessage(message, isMe);
      case AppThemeVariant.v9RoundedBubbles:
        return _buildBubbleMessage(context, message, isMe, primaryColor);
      default:
        return _buildDefaultMessage(context, message, isMe, primaryColor, surfaceColor);
    }
  }

  Widget _buildDefaultMessage(
    BuildContext context,
    dynamic message,
    bool isMe,
    Color primaryColor,
    Color surfaceColor,
  ) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? primaryColor : surfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.content,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              timeago.format(message.createdAt),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeonMessage(dynamic message, bool isMe) {
    final color = isMe ? const Color(0xFF00FFFF) : const Color(0xFFFF00FF);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: color, width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(color: color, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Text(
              timeago.format(message.createdAt).toUpperCase(),
              style: TextStyle(
                color: color.withValues(alpha: 0.6),
                fontSize: 9,
                letterSpacing: 1,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLuxuryMessage(dynamic message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFD4AF37) : const Color(0xFF1A1A1A),
          border: isMe
              ? null
              : Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isMe ? Colors.black : Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              timeago.format(message.createdAt),
              style: TextStyle(
                color: isMe
                    ? Colors.black.withValues(alpha: 0.6)
                    : Colors.grey[500],
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastelMessage(BuildContext context, dynamic message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFFF6B9D) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: (isMe ? const Color(0xFFFF6B9D) : Colors.grey)
                  .withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timeago.format(message.createdAt),
              style: TextStyle(
                color: isMe
                    ? Colors.white.withValues(alpha: 0.7)
                    : Colors.grey[500],
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoldMessage(dynamic message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? Colors.red : Colors.black,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content.toString().toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timeago.format(message.createdAt).toUpperCase(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubbleMessage(
    BuildContext context,
    dynamic message,
    bool isMe,
    Color primaryColor,
  ) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: isMe
              ? LinearGradient(
                  colors: [primaryColor, const Color(0xFF81ECEC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isMe ? null : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: (isMe ? primaryColor : Colors.grey).withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.grey[800],
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timeago.format(message.createdAt),
              style: TextStyle(
                color: isMe
                    ? Colors.white.withValues(alpha: 0.7)
                    : Colors.grey[500],
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(
    BuildContext context,
    AppThemeVariant variant,
    Color primaryColor,
    Color surfaceColor,
    Color backgroundColor,
    double cardRadius,
  ) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return _buildNeonInput();
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryInput();
      case AppThemeVariant.v6PlayfulPastel:
        return _buildPastelInput();
      case AppThemeVariant.v7HighContrastRed:
        return _buildBoldInput();
      case AppThemeVariant.v9RoundedBubbles:
        return _buildBubbleInput(primaryColor);
      default:
        return _buildDefaultInput(primaryColor, surfaceColor, backgroundColor);
    }
  }

  Widget _buildDefaultInput(Color primaryColor, Color surfaceColor, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  filled: true,
                  fillColor: backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeonInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Color(0xFF00FFFF), width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF00FFFF), width: 1),
                ),
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(color: Color(0xFF00FFFF)),
                  decoration: const InputDecoration(
                    hintText: 'ENTER MESSAGE >',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2,
                      fontFamily: 'monospace',
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFFFF00), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFFF00).withValues(alpha: 0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(Icons.send, color: Color(0xFFFFFF00)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLuxuryInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        border: Border(
          top: BorderSide(color: Color(0xFFD4AF37), width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                  ),
                ),
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Your message...',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      letterSpacing: 1,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFFD4AF37),
                ),
                child: const Icon(Icons.send, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastelInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B9D).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Say something nice... 💕',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xFFFFF5F7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF6B9D),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoldInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.black,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'TYPE MESSAGE',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.red,
                child: const Icon(Icons.send, color: Colors.white, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubbleInput(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xFFE8F8F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, const Color(0xFF81ECEC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
