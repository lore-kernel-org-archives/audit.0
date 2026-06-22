Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5D392C42
	for <audit@vger.kernel.org>; Mon, 22 Jun 2026 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117769; cv=none; b=ebQ0KpWZU79dkG4JYE7/TeyAlCFPUwixAKdOVkOKD1g1CuDl2Pj8FBDWkJ2852KB1mgr9oUvxgR2nqVVR5BaXOEVWeJF3II8cZKI639ZX1fAD8KzuPYAEBnhzdeEJxJlZq3GKlgTsp+77C7AGcUnjHgZ+obSaMBzMOWGMfOBpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117769; c=relaxed/simple;
	bh=IER6Q4RbEHU+TqBNCFXousE9wjBARqNFqdXSUnckiEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLVeNsCmZXJbf2GpVbtQEyfEbgxhdEKzXndO//tokSNcUb5iTFWxjOFoKcSjd6Wcj7Lvlkb+SxzQGb9Ai4MkjvNNmTVGvj3sMGvO16oi5FzbqJpRPMXJXkiFWSkQIyu+6XUpOpVon+OmDzzXTbVUtoY80E3DFK+LIHQmPEQxl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROskh/8t; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROskh/8t"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-46255b269c2so3112288f8f.3
        for <audit@vger.kernel.org>; Mon, 22 Jun 2026 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117765; x=1782722565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFnA4MB3rhX4hW9kwKpEDdWQh6n3FEg0cpZAkJWsmhQ=;
        b=ROskh/8tfIJaOesnEZqCHlQNJbZWki5RbTqza/lsX5eovRkaYimKsd+YXB/k2zMi/m
         /oMxYwZTti4VBo4Zu7g+ne/XnDzRPkeytOwEHJ1QPmKrsfs8gcwvBhLar3NiR6OJGf0L
         +J8cEmu4EM9EXTaOXzKCB3rcDsY6oG2rx0tNv24ObV21OlAfSpd7lVCwHX7BM5qlSMrU
         0Y+stJ4hQbL/MqG06XGIR3AP4JZd7J5kU0fBgPGMIRm0x4a2O+CoKjF5iYge8niCKb3T
         4w+mIabC6ghr2q6JO+5qYmEFnGpSPuxK8BZC5l6QgOh4KqNC3bjBRyqs8iNZbdgiJDoz
         PvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117765; x=1782722565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bFnA4MB3rhX4hW9kwKpEDdWQh6n3FEg0cpZAkJWsmhQ=;
        b=VW1Ps9p3XsCWm6/CZQ9mIbpaXQ0bcg0wyJTeW6Iv9ew2JRPLzrkSThgbXFsEsl0VSR
         ntDAfOH808j99w+fgw5Te4bOvgu905WY4UPp7pxeMUKBsocZKjI4besq5Bj5JY3i5JLQ
         yXsIbs7Te/puwucHSYukcB8+CZbkmF/8LTZTn+UVdtV4YgdcZqSGtsZ81x49QtXs45bc
         C7brmXcztCK0xFGec2/gy+vDgvIuiY7uLi1p2INxuUgX/WFEUacr8K0rlIrCyHhsaIZz
         gZuxQ+AatQjEEfj+OA3pgsG0R3f2wJ2JMUiZ9RV8/96D+5oj+HQk19j9JZBujk8WviyW
         aR4g==
X-Forwarded-Encrypted: i=1; AHgh+Ro8k4jqA60hYIZIm+DWq8yYV6DqJ8Ce9VYYrZG8PTE+SlqOBciXs2NMXJCKJr3fcXJkutdzRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhg77cCc/jzeVFUS+96qm9eINvJTtCpX89tt4ReC7VRWReGZtI
	C4LF+01y1vwLpLvuJiqWjW9ROj/6T7b0dsqqif5DqkgbVbuFhzEPJdce
X-Gm-Gg: AfdE7clE2c2ygNMzvYn0lSDfdTHeeMvBpR7J8qiu1Ixm3uCBgAxq57XRjjvSCOFcvG/
	fAJq05oCNB/hb1QYN7ts6ZvEDMeoH0IkFQg25b283BSrMO25s678NEEKko3naBouoj+kwNecloB
	ylMg2mvVKUsK/apJWuNc3SpD7fGV+OD6wlyzqy1+0HPMev0UijsEwNGzePZukslE9qYaPvw3Xa4
	Lxb4+JW7+qWpqqJO1ciDb3DUqv6e9cKPMcStUcZvei6sa4d++aVII6zJ/dLaxghLxzb8wMyhKAM
	rS4YfsL38bzIScyXI170X/pQ73/rbUPcl9jCdsLtIOrUmeDM76rieEnPAAUurU6F4vuUURZz3e0
	SCifuG4RsTvpBSen0bHqnMbHy5jBcIk4zuMyl2+OgDniZovitoXEaATu/dgElSKHeE312VSIcFm
	qu6P7Rly0U9QRPu+IDv0N+AGvhGEMHRis5AS0v5sWqnmoLzVloJalpPgJnpmwN
X-Received: by 2002:a05:6000:2006:b0:460:1e5a:2267 with SMTP id ffacd0b85a97d-4650090b736mr21019711f8f.17.1782117764761;
        Mon, 22 Jun 2026 01:42:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm24839972f8f.29.2026.06.22.01.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:42:44 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:42:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo
 <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Paul Moore <paul@paul-moore.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Howells
 <dhowells@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>, Randy Dunlap
 <rdunlap@infradead.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Philipp
 Stanner <phasta@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, audit@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kexec@lists.infradead.org, live-patching@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pm@vger.kernel.org, rcu@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-mm@kvack.org, virtualization@lists.linux.dev, damon@lists.linux.dev,
 llvm@lists.linux.dev, Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v3 1/7] list: Add mutable iterator variants
Message-ID: <20260622094242.64531b9a@pumpkin>
In-Reply-To: <20260622040533.29824-2-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
	<20260622040533.29824-2-kaitao.cheng@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 12:05:31 +0800
Kaitao Cheng <kaitao.cheng@linux.dev> wrote:

> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> The list_for_each*_safe() helpers are used when the loop body may
> remove the current entry.  Their API exposes the temporary cursor at
> every call site, even though most users only need it for the iterator
> implementation and never reference it in the loop body.
> 
> Add *_mutable() variants for list and hlist iteration.  The new helpers
> support both forms: callers may keep passing an explicit temporary cursor
> when they need to inspect or reset it, or omit it and let the helper use
> a unique internal cursor.

I'm not really sure 'mutable' means anything either.
It is possible to make it valid for the loop body (or even other threads)
to delete arbitrary list items - but that needs significant extra overheads.

It might be worth doing something that doesn't need the extra variable,
but there is little point doing all the churn just to rename things.

> 
> This makes call sites that only mutate the list through the current entry
> less noisy, while keeping the existing *_safe() helpers available for
> compatibility.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  include/linux/list.h | 269 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 231 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 09d979976b3b..1081def7cea9 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -7,6 +7,7 @@
>  #include <linux/stddef.h>
>  #include <linux/poison.h>
>  #include <linux/const.h>
> +#include <linux/args.h>
>  
>  #include <asm/barrier.h>
>  
> @@ -763,28 +764,72 @@ static inline void list_splice_tail_init(struct list_head *list,
>  #define list_for_each_prev(pos, head) \
>  	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
>  
> -/**
> - * list_for_each_safe - iterate over a list safe against removal of list entry
> - * @pos:	the &struct list_head to use as a loop cursor.
> - * @n:		another &struct list_head to use as temporary storage
> - * @head:	the head for your list.
> +/*
> + * list_for_each_safe is an old interface, use list_for_each_mutable instead.
>   */
>  #define list_for_each_safe(pos, n, head) \
>  	for (pos = (head)->next, n = pos->next; \
>  	     !list_is_head(pos, (head)); \
>  	     pos = n, n = pos->next)
>  
> +#define __list_for_each_mutable_internal(pos, tmp, head)		\
> +	for (typeof(pos) tmp = (pos = (head)->next)->next;		\

Use auto

> +	     !list_is_head(pos, (head));				\
> +	     pos = tmp, tmp = pos->next)
> +
> +#define __list_for_each_mutable1(pos, head)				\
> +	__list_for_each_mutable_internal(pos, __UNIQUE_ID(next), head)
> +
> +#define __list_for_each_mutable2(pos, next, head)			\
> +	list_for_each_safe(pos, next, head)
> +
>  /**
> - * list_for_each_prev_safe - iterate over a list backwards safe against removal of list entry
> + * list_for_each_mutable - iterate over a list safe against entry removal
>   * @pos:	the &struct list_head to use as a loop cursor.
> - * @n:		another &struct list_head to use as temporary storage
> - * @head:	the head for your list.
> + * @...:	either (head) or (next, head)
> + *
> + * next:	another &struct list_head to use as optional temporary storage.
> + *		The temporary cursor is internal unless explicitly supplied by
> + *		the caller.
> + * head:	the head for your list.
> + */
> +#define list_for_each_mutable(pos, ...)					\
> +	CONCATENATE(__list_for_each_mutable, COUNT_ARGS(__VA_ARGS__))	\
> +		(pos, __VA_ARGS__)

The variable argument count logic really just slows down compilation.
Maybe there aren't enough copies of this code to make that significant.
But just because you can do it doesn't mean it is a gooD idea.
I'm also not sure it really adds anything to the readability.

And, it you are going to make the middle argument optional there is
no need to change the macro name.

	David


