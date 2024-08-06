Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631558203
	for <audit@vger.kernel.org>; Tue,  6 Aug 2024 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913813; cv=none; b=Dg3J8kBcJ8077BR+dfmVOGsvS2IF0N4yp6po4LmvRmM+bblumCAgsoa+kyi6rGHSlNO4ge5dqbmSMkz1zHUAD0XETXJPpRjHSm+S7lfA5aDhf4MT95SvlQ2v5O/Uh5T578G0noov1UrYm0pB+ZuLDOf99K48hyg/2liq00dTKqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913813; c=relaxed/simple;
	bh=M8lCPbpz8MJ7MmX8w6ySSM335BKWQPUYdlyNM4pcNL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/yfMsE+UMnAWCrdJtGTrxHIGok8gijREnxQhmivWym+ZihF1VbeDaI6nY35R0wd2WP6NLbPx7Svh9uNC4+N+Y3MpEJik/XQy1gadI1gIPqev4vyrTY/OPoEW7iQpS72aM27eGZQlQoQSTitX7vpTdGRpyxdWzLdPs79pJ0Rtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vt6hGsg8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vt6hGsg8"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so73030a12.3
        for <audit@vger.kernel.org>; Mon, 05 Aug 2024 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722913810; x=1723518610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=Vt6hGsg8tkeVi0W2Xbo+GM0jM3j+HYRG6Rox3/TRTDwNVT7wkm0brw7CzdCMhxmcsN
         MmuzchUm9+i9yxsf5mvvEzdvyi5lHBRu2duGKq+cLF3CTfXvpcKJZZ80UApX+EByeqc8
         eR7SUZtjdP4hZ7kCBKuGIb3jVFoeyp+g92EiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913810; x=1723518610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=AsD+7Af3Owh3CWZjmipHevcgCizfG+5OuSqkHZKIH7SWevQPOYQVv5tU7eUEVywcpq
         +tgWQWSNtIFooZpkxMaUCi0c6Eb4WnAfUg5HnB2g1CHdRbAbyU7X0Ye8Xg4TU4OSsoiT
         ZuBiP2K0EMuooq/Yyu+kGBdSbPfUyxSbIKG/T3FctjpNym1t+K48rpm9ulhuKYH0L2fH
         +wCnFzgu1bUpsOnAp8ujQ8aILOv+OivjxrJcwRFTKX7jyysIKX6g7Gv8Z+8xKz3j+nqg
         1xM6CnBMA/5UcsGYfkB/i2lokZh7XO8d7TLZ9ybwmoOfkPLcLYqQOp/rRLceIFr5l0Nw
         1LFw==
X-Forwarded-Encrypted: i=1; AJvYcCUPgvB+PqYjnO0bfZM16LXaHmuQV5UyU+MHkY2S5pB9vducwygNa9o7EOUfsw7QneyqZmTyu8hymf0PlkQev/gRorsx2I0=
X-Gm-Message-State: AOJu0YzTXT0TqkVwlPrdv/0XK/GbFZnKKeQbpmjWvkrnbT2ATf0Nvcne
	uhaRxrZwPvE5eU9g6iBb2w1mpRs4CbYvCUN7vHWLeyMkh2NHs2W7kHepTG6JomsLRLR8gihW/rI
	cxMY9sg==
X-Google-Smtp-Source: AGHT+IGTA33WGBaMBUQeRGsHd7mRXte2h3hK0SuV4rv64lmWxYhYD1aVE0nHgajgpvPYxbAbcUwMWg==
X-Received: by 2002:a17:907:970e:b0:a7d:2a62:40e9 with SMTP id a640c23a62f3a-a7dc509872dmr858492066b.50.1722913809859;
        Mon, 05 Aug 2024 20:10:09 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cae0sm505639566b.56.2024.08.05.20.10.08
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so4330166b.3
        for <audit@vger.kernel.org>; Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0qGXV6JqPDZzBQR3fV/eLaGZkedtS4lumtZtGDmVPaVkXUgT2/1x0A7JfqdXmaiSg746ZWEbzkWufHTHI1yapka0Ncf0=
X-Received: by 2002:a17:907:da9:b0:a6f:4fc8:266b with SMTP id
 a640c23a62f3a-a7dc4db9f44mr1005005366b.3.1722913808064; Mon, 05 Aug 2024
 20:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com> <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
 <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
In-Reply-To: <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 20:09:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> One concern about removing the BUILD_BUG_ON() is that if we extend
> TASK_COMM_LEN to a larger size, such as 24, the caller with a
> hardcoded 16-byte buffer may overflow.

No, not at all. Because get_task_comm() - and the replacements - would
never use TASK_COMM_LEN.

They'd use the size of the *destination*. That's what the code already does:

  #define get_task_comm(buf, tsk) ({                      \
  ...
        __get_task_comm(buf, sizeof(buf), tsk);         \

note how it uses "sizeof(buf)".

Now, it might be a good idea to also verify that 'buf' is an actual
array, and that this code doesn't do some silly "sizeof(ptr)" thing.

We do have a helper for that, so we could do something like

   #define get_task_comm(buf, tsk) \
        strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)

as a helper macro for this all.

(Although I'm not convinced we generally want the "_pad()" version,
but whatever).

                    Linus
