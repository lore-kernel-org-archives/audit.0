Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0936BFD5
	for <audit@vger.kernel.org>; Sun,  2 Jun 2024 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359089; cv=none; b=HFPM/YeNPNKZNmpwxBItjd8wF9tzOWUcwVYQ/9frz5KwxrK7Hl60Odvnr9RUvqJPVZF9n3NCKw3iT/CMz675sgpxNLFN70mSP6pUZKLj24a/0OiahYwUQQYJB54woQJEswO6lTmQ9LfyQl8m9sD3F9zbDVyYMPL51wQ20uI4hyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359089; c=relaxed/simple;
	bh=pPpQRofU4aUuWzH8F/QKbmIvQmhWX6HwGWlPQg5XjJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbox+ji2P3O8yRQbXOgFjJGrq7gaaISEAiz0L8Z9P+UHK4KUxxF4LGj7qz551nEWWjoYDgPHR0DsRxDWvm1wDHH5TN01jVjPoR+UFEkbQbcRK/yZMtS7+N9JWbl/NpGCMx+VRHVEb/5r7EqC7bE9RpdqfoaCPUaZVG6AmXX6dNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PbXUfgtG; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PbXUfgtG"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2e724bc466fso42210591fa.3
        for <audit@vger.kernel.org>; Sun, 02 Jun 2024 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717359085; x=1717963885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePqimL8VaYhHEJxz6pSQAbNa/K23yw/URyexsY++IVA=;
        b=PbXUfgtGG3WgRYt8xS/HOC8+XuynnEXPnzP+r2gKJjWqBP+kFvCii0YYIFgH0AcUCP
         bLhe+Zxt//4YOzN3Fz6TUlJqi6HZZAvgGTn9cyKf1CuW/aarUQ5g6PWlH5aCaAhNXu+2
         YCW2iqqI6VeFYyOBSIF1EHQ9/Xm6WgJxmy7zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717359085; x=1717963885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePqimL8VaYhHEJxz6pSQAbNa/K23yw/URyexsY++IVA=;
        b=WnJ4i7s6KhiFRHTvf6NlAB+i3i+EmG2fCzJEtbvGMIJ9WVTWlW7/Pc1jogbxg6upGd
         7IAsrpEJ4rHEsaR0jr+/1cfer/Ka8A2kr7/2KyPQwQJlGdawFyYDPanLF4h2eIwpgoVT
         zymN0aZKZIMb8+jvnZVoqb9WhPwsQfANW7vPrmVKCoQF1EKPQCPVtGpUb2zc3jpveuUk
         Kij1imW62EF5XG13zM9amCqjtQ/xwznuISWqa/Il5Nt7EnJRkJPMH+HV/JV7fxcS+0Wf
         +jLRmxOVcfIc69cUYtJurIWlJpJcCjWvp4jDXH2lfaof1ysf5bAFlI/gz8GP5OgrcjZ1
         7+1g==
X-Forwarded-Encrypted: i=1; AJvYcCVvPqdWybEpHB9Vq27IzG5TLDeYN9vqEyjllseqnoc14LcdPfdGhnZ3WeJBW/+sCcdlOwqS/jvrYgRZANw1lHGL333Kcbo=
X-Gm-Message-State: AOJu0YxTV/iYWcf1vxb93261y63rl5GyGa8G+o+kDfq7PBkrQe7yW3k2
	vWFH2sAvDW2/blAJLB7zHQinIz/5RCUbRwFqiY38LsBmmF7Bgbdkl2Ms71/nf8sgb1Xi8bCC9fk
	wy8s=
X-Google-Smtp-Source: AGHT+IEvFvyHJdgyX3cOpIdU5ImKQ0OsSRozs6pKquBagfrNW02lRvfaThkQLfB6ye8wzi+SSR2swA==
X-Received: by 2002:a2e:a696:0:b0:2ea:8f93:a496 with SMTP id 38308e7fff4ca-2ea951e4bd4mr50112951fa.33.1717359084857;
        Sun, 02 Jun 2024 13:11:24 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cf0bcdsm9775611fa.120.2024.06.02.13.11.24
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 13:11:24 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b7c82e39eso3592717e87.1
        for <audit@vger.kernel.org>; Sun, 02 Jun 2024 13:11:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0+3eVpBCx8YxBWbTHUxKEu6xOqbbjeZ+Qhlvk2YBm6M1Grug45Y6VBGuFSOfWtCQiF7myQEAvxqtrG8HQoU1BcQnRJPM=
X-Received: by 2002:ac2:5dc3:0:b0:51a:f689:b4df with SMTP id
 2adb3069b0e04-52b896bde2emr5480833e87.44.1717359084107; Sun, 02 Jun 2024
 13:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <87ikysdmsi.fsf@email.froward.int.ebiederm.org> <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
 <CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com> <874jabdygo.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874jabdygo.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Jun 2024 13:11:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkgtCjr3aHFnFifYtKnvet0M9jehfMFYhYpL_F7Jbmtg@mail.gmail.com>
Message-ID: <CAHk-=wgkgtCjr3aHFnFifYtKnvet0M9jehfMFYhYpL_F7Jbmtg@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Jun 2024 at 10:53, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The read may race with a write that is changing the location
> of '\0'.  Especially if the new value is shorter than
> the old value.

It *shouldn't* happen.

So 'strscpy()' itself is written to be NUL-safe, in that if it ever
copies a NUL character, it will stop. Admittedly the byte loop at the
end might technically need a READ_ONCE() for that to eb strictly true
in theory, but in practice it already is.

And even if the new string is shorter, the comm[] array will always
have a NUL terminator _somewhere_, in how the last byte is never
non-NUL.

Now, the only real issue is if something writes *to* the  comm[] array
without following the rules properly - like writing a non-NULL
character to the end of the array before then filling it in with NUL
again.

But that would be a bug on the comm[] writing side, I feel, not a bug
on the reader side.

               Linus
