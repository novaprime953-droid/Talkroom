// Service Export Index
export { default as RoomService } from './RoomService';
export { default as UserService } from './UserService';
export { default as WalletService } from './WalletService';
export { default as PKService } from './PKService';

// Import services
import RoomService from './RoomService';
import UserService from './UserService';
import WalletService from './WalletService';
import PKService from './PKService';

// Initialize gifts (default gifts)
export function initializeDefaultData() {
  // Add default gifts
  WalletService.registerGift({
    id: 'gift_1',
    name: 'Rose',
    description: 'A beautiful rose',
    icon: '🌹',
    animation: 'rose.svga',
    diamondCost: 1,
    category: 'normal',
    rarity: 'common',
    comboable: true,
  });

  WalletService.registerGift({
    id: 'gift_2',
    name: 'Diamond Ring',
    description: 'Elegant diamond ring',
    icon: '💍',
    animation: 'ring.svga',
    diamondCost: 50,
    category: 'special',
    rarity: 'epic',
    comboable: true,
  });

  WalletService.registerGift({
    id: 'gift_3',
    name: 'Lucky Gift',
    description: 'Random lucky gift',
    icon: '🎁',
    animation: 'lucky.svga',
    diamondCost: 99,
    category: 'lucky',
    rarity: 'rare',
    comboable: false,
  });

  WalletService.registerGift({
    id: 'gift_4',
    name: 'Super Gift',
    description: 'Super special gift',
    icon: '⭐',
    animation: 'super.svga',
    diamondCost: 888,
    category: 'super',
    rarity: 'legendary',
    comboable: false,
  });
}

export { RoomService, UserService, WalletService, PKService };
